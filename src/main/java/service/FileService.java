package service;

import java.io.File;
import java.io.FileNotFoundException;

import com.mongodb.gridfs.GridFSDBFile;

/**
 * @author lionel
 * @version 1.0
 * 
 */
public interface FileService {

	public String saveFile(File file, String name) throws FileNotFoundException;

	public void delete(String name);

	public String upsertFile(String oldname, File file, String name) throws FileNotFoundException;

	public GridFSDBFile getFile(String filename);
}
