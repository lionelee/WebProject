package daoImp;

import java.io.InputStream;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;

import com.mongodb.gridfs.GridFSDBFile;

import dao.FileDao;

public class FileDaoImp implements FileDao {
	private GridFsTemplate gridFsTemplate;

	public void setGridFsTemplate(GridFsTemplate gridFsTemplate) {
		this.gridFsTemplate = gridFsTemplate;
	}

	public GridFsTemplate getGridFsTemplate() {
		return this.gridFsTemplate;
	}

	public void save(InputStream content, String filename) {
		gridFsTemplate.store(content, filename);
	}

	public void delete(String filename) {
		Query query = new Query().addCriteria(Criteria.where("filename").is(filename));
		gridFsTemplate.delete(query);
	}

	public GridFSDBFile getByName(String filename) {
		Query query = new Query().addCriteria(Criteria.where("filename").is(filename));
		return gridFsTemplate.findOne(query);
	}

}
