package trungduc.vn.dao;

import java.util.List;
import trungduc.vn.entity.Category;

public interface ICategoryDao {
    void insert(Category category);
    void update(Category category);
    void delete(int categoryId) throws Exception;
    Category findById(int categoryId);
    List<Category> findAll();
}