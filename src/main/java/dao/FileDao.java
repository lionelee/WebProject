package dao;

import java.io.InputStream;

import com.mongodb.gridfs.GridFSDBFile;

public interface FileDao {

	public void save(InputStream content, String filename);

	public GridFSDBFile getByName(String filename);

	public void delete(String filename);
}
