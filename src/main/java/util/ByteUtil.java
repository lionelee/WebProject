package util;

import java.io.ByteArrayOutputStream;
import java.io.File;

import javax.imageio.stream.FileImageInputStream;

public class ByteUtil {

	public static byte[] FileToByte(File file) {
		byte[] ret = null;
		try {
			FileImageInputStream fiStream = new FileImageInputStream(file);
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int n;
			while ((n = fiStream.read(buffer)) != -1) {
				outputStream.write(buffer, 0, n);
			}
			ret = outputStream.toByteArray();
			fiStream.close();
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

}
