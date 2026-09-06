package trungduc.vn.services.impl;

import java.util.List;
import trungduc.vn.dao.IProductDao;
import trungduc.vn.dao.impl.ProductDaoImpl;
import trungduc.vn.entity.Product;
import trungduc.vn.services.IProductService;

public class ProductServiceImpl implements IProductService {

    private IProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int productId) throws Exception {
        productDao.delete(productId);
    }

    @Override
    public Product findById(int productId) {
        return productDao.findById(productId);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findTop10Latest() {
        return productDao.findTop10Latest();
    }

    @Override
    public List<Product> findPaginated(int page, int pageSize) {
        if (page < 1) {
            page = 1;
        }
        return productDao.findPaginated(page, pageSize);
    }

    @Override
    public int countAll() {
        return productDao.countAll();
    }
}