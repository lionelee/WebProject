package dao;

import model.Profile;

public interface ProfileDao {

	public void save(Profile profile);

	public void delete(int uid);

	public void updateIntro(int uid, String intro);

	public void updatePicture(int uid, byte[] pic);

	public Profile getProfileByUid(int uid);

}
