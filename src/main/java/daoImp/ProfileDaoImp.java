package daoImp;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import dao.ProfileDao;
import model.Profile;

public class ProfileDaoImp implements ProfileDao {

	private MongoTemplate mongoTemplate;

	public void setMongoTemplate(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
	}

	public MongoTemplate getMongoTemplate() {
		return this.mongoTemplate;
	}

	public void save(Profile profile) {
		mongoTemplate.save(profile);
	}

	public void delete(int uid) {
		mongoTemplate.remove(Query.query(Criteria.where("uid").is(uid)), Profile.class);
	}

	public void updateIntro(int uid, String intro) {
		Query query = Query.query(Criteria.where("uid").is(uid));
		Update update = Update.update("intro", intro);
		mongoTemplate.updateFirst(query, update, Profile.class);
	}

	public void updatePicture(int uid, byte[] pic) {
		Query query = Query.query(Criteria.where("uid").is(uid));
		Update update = Update.update("pic", pic);
		mongoTemplate.updateFirst(query, update, Profile.class);
	}

	public Profile getProfileByUid(int uid) {
		return mongoTemplate.findOne(Query.query(Criteria.where("uid").is(uid)), Profile.class);
	}

}
