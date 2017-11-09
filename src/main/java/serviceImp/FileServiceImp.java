package serviceImp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import com.mongodb.gridfs.GridFSDBFile;

import dao.FileDao;
import service.FileService;

public class FileServiceImp implements FileService {
	private FileDao fileDao;

	public void setFileDao(FileDao fileDao) {
		this.fileDao = fileDao;
	}

	public String saveFile(File file, String name) throws FileNotFoundException {
		FileInputStream content = new FileInputStream(file);
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = df.format(new Date());
		Random rand = new Random();
		int randnum = rand.nextInt(100);
		int index = name.indexOf(".");
		String appen = name.substring(index);
		String filename = date + randnum + appen;
		fileDao.save(content, filename);
		return filename;
	}

	public void delete(String name) {
		fileDao.delete(name);
	}

	public String upsertFile(String oldname, File file, String name) throws FileNotFoundException {
		FileInputStream content = new FileInputStream(file);
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = df.format(new Date());
		Random rand = new Random();
		int randnum = rand.nextInt(100);
		int index = name.indexOf(".");
		String appen = name.substring(index);
		String filename = date + randnum + appen;
		fileDao.delete(oldname);
		fileDao.save(content, filename);
		return filename;
	}

	public GridFSDBFile getFile(String filename) {
		return fileDao.getByName(filename);
	}
}
