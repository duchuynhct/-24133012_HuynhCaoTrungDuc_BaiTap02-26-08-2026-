package trungduc.vn.services;

import java.util.List;
import trungduc.vn.entity.Category;

public interface ICategoryService {
    void insert(Category category);
    void update(Category category);
    void delete(int categoryId) throws Exception;
    Category findById(int categoryId);
    List<Category> findAll();
}