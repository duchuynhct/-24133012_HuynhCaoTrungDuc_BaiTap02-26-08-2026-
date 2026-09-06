package trungduc.vn.dao;

import java.util.List;
import trungduc.vn.entity.User;

public interface IUserDao {

    void insert(User user);

    void update(User user);

    void delete(String username) throws Exception;

    User findById(String username);

    User findByEmail(String email);

    List<User> findAll();

    boolean checkExistUsername(String username);

    boolean checkExistEmail(String email);
}