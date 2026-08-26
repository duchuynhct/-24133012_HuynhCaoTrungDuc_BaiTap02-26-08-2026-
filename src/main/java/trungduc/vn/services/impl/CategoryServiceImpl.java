package trungduc.vn.services.impl;

import java.util.List;
import trungduc.vn.dao.ICategoryDao;
import trungduc.vn.dao.impl.CategoryDaoImpl;
import trungduc.vn.entity.Category;
import trungduc.vn.services.ICategoryService;

public class CategoryServiceImpl implements ICategoryService {

    private ICategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(int categoryId) throws Exception {
        categoryDao.delete(categoryId);
    }

    @Override
    public Category findById(int categoryId) {
        return categoryDao.findById(categoryId);
    }

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }
}