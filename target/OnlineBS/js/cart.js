$(document).ready(function() {
	$.ajax({
		url : 'cart_load',
		async : false,
		dataType : 'json',
		success : function(data) {
			var result = "";
			var arrLen = data.length;
			if (arrLen > 0) {
				for (var i = 0; i < arrLen; i++) {
					result += '<tr><td><input class="check-one check" type="checkbox" /></td>\
                 	<td><img id="img" src="book_image?i='+ data[i].image+ '" width="50px;"height="75px;"\
                 	alt="'+ data[i].bid+ '"/></td><td class="goods"><p id="title" style="padding-top: 1.3em;">'
					+ data[i].title+ '</p></td><td class="selling-price number small-bold-red" data-bind="'
                 	+data[i].price+'"></td><td><div class="input-group">\
                 	<span class="btn input-group-addon minus">-</span>\
                  	<input type="text" class="number form-control input-sm" value="'+data[i].num+'" />\
                  	<span class="btn input-group-addon plus">+</span></div></td>\
                 	<td class="subtotal number small-bold-red"></td>\
                 	<td class="action"><span class="delete btn btn-xs btn-primary mar">delete</span></td></tr>';
				}
				$('.carts').append(result);
				$(cartTable).find("tr:gt(0)").each(function() {
					var price = parseInt($(this).find(".selling-price").data("bind"));
					var pri = price / 100.00;
					var qty = parseInt($(this).find(":text").val());
					var subtotal = price* qty;
					var result = subtotal / 100.00;
					$(this).find(".selling-price").text($.formatMoney(pri,2));
					$(this).find(".subtotal").text($.formatMoney(result,2)).data("bind",subtotal);
				});
			}
			if (arrLen == 0)
				$('#Modal').modal('show');
		},
		error : function(xhr, type) {
			$('#logcheck').modal('show');
		}
	});

	$('#fm').on("submit", function() {
	var citems = [];
	$(cartTable).find("tr:gt(0)").each(function() {
		if ($(this).find(":checkbox").prop("checked") == true) {
			var cbid = $(this).find("#img").attr("alt");
			var ctitle = $(this).find('#title').text();
			var cimage = $(this).find('#img').attr("src");
			var cimage = cimage.substring(cimage.indexOf('=') + 1);
			var cnum = $(this).find(":text").val();
			var pri = $(this).find(".selling-price").data("bind");
			var cjson = {
				bid : cbid,
				title : ctitle,
				image : cimage,
				price : pri,
				num : cnum
			};
			citems.push(cjson);
		}
	});
	var ctotal = $('#priceTotal').data("bind");
	if (ctotal == null || isNaN(ctotal) || ctotal == 0) {
		alert("you must choose one!");
		return false;
	} else {
		$('#total').val(ctotal);
		$('#items').val(JSON.stringify(citems));
		}
	});
	
	
    /*
     * 计算购物车中每一个产品行的金额小计
     *
     * 参数 row 购物车表格中的行元素tr
     *
     */
    function getSubTotal(row) {
        var price = parseInt($(row).find(".selling-price").data("bind"));
        var pri = price/100.00;
        var qty = parseInt($(row).find(":text").val());
        var subtotal = price * qty;
        var result = subtotal/100.00;
        $(row).find(".selling-price").text($.formatMoney(pri, 2));
        $(row).find(".subtotal").text($.formatMoney(result, 2)).data("bind", subtotal);
    };

    /*
     * 计算购物车中产品的累计金额
     */
    function getTotal() {
        var qtyTotal = 0;
        var itemCount = 0;
        var total = 0;
        $(cartTable).find("tr:gt(0)").each(function() {
        	getSubTotal(this);
            if ($(this).find(":checkbox").prop("checked") == true) {
                itemCount++;
                total += parseInt($(this).find(".subtotal").data("bind"));
                qtyTotal += parseInt($(this).find(":text").val());
            }
        });
        var priceTotal = total/100.00;
        $("#itemCount").text(itemCount).data("bind", itemCount);
        $("#qtyCount").text(qtyTotal).data("bind", qtyTotal);
        $("#priceTotal").text($.formatMoney(priceTotal, 2)).data("bind", total);
    };

    var cartTable = $("#cartTable");

    getTotal();

    //为每一个勾选框指定单击事件
    $(cartTable).find(":checkbox").click(function() {
        //全选框单击
        if ($(this).hasClass("check-all")) {
            var checked = $(this).prop("checked");
            $(cartTable).find(".check-one").prop("checked", checked);
        }

        //如果手工一个一个的点选了所有勾选框，需要自动将“全选”勾上或是取消
        var items = cartTable.find("tr:gt(0)");
        $(cartTable).find(".check-all").prop("checked", items.find(":checkbox:checked").length == items.length);
        //设置结算按钮disabled属性
        $("#btn_settlement").attr("disabled", items.find(":checkbox:checked").length == 0);

        getTotal();
    });

    //为数量调整的＋ －号提供单击事件，并重新计算产品小计
    /*
     * 为购物车中每一行绑定单击事件，以及每行中的输入框绑定键盘事件
     * 根据触发事件的元素执行不同动作
     *   增加数量
     *   减少数量
     *   删除产品
     *
     */
    $(cartTable).find("tr:gt(0)").each(function() {
        var input = $(this).find(":text");
        var bid = $(this).find("#img").attr("alt");
        
        //为数量输入框添加事件，计算金额小计，并更新总计
        $(input).keyup(function() {
        	var val = $(this).val();
            var value = parseInt($(this).val());
            if ( val.charAt(0) == '-'){
				$(this).val(val.replace(/^\-/g,''));
				return;
			}
            if(val.toString().split(".").length > 1){
				$(this).val(value);
				return;
			}
            if (isNaN(val) || (value < 1)) { 
            	$(this).val(1); 
            	return;
            }
            if(value > 99)
				$('#in').val(99);
            getSubTotal($(this).parent().parent()); //tr element
            getTotal();
            $.post("cart_update?bid="+bid+"&num="+val);
        });

        //为数量调整按钮、删除添加单击事件，计算金额小计，并更新总计
        $(this).click(function() {
            var val = parseInt($(input).val());
            if (isNaN(val) || (val < 1)) { val = 1; }
            var theEvent = window.event || arguments.callee.caller.arguments[0];
            var srcElement = theEvent.srcElement;
            if (!srcElement) {
               srcElement = theEvent.target;
            }
            if ($(srcElement).hasClass("minus")) {
                if (val > 1) val--;
                input.val(val);
                getSubTotal(this);
                $.post("cart_update?bid="+bid+"&num="+val);
            }
            else if ($(srcElement).hasClass("plus")) {
                if (val < 99) val++;
                input.val(val);
                getSubTotal(this);
                $.post("cart_update?bid="+bid+"&num="+val);
            }
            else if ($(srcElement).hasClass("delete")) {
                if (confirm("Are you sure to remove this from cart？")) {
                    $(this).remove();
                    $.post("cart_delete?bid="+bid);
                }
            }
            getTotal();
        });
    });
});