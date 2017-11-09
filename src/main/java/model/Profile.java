package model;

import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "profile")
public class Profile {

	@Indexed(unique = true)
	private int uid;
	private byte[] pic;
	private String intro;

	public Profile(int uid, byte[] pic, String intro) {
		this.uid = uid;
		this.pic = pic;
		this.intro = intro;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public byte[] getPic() {
		return pic;
	}

	public void setPic(byte[] pic) {
		this.pic = pic;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

}
