package trungduc.vn.controllers.web;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import trungduc.vn.entity.Product;
import trungduc.vn.services.IProductService;
import trungduc.vn.services.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Lấy 10 sản phẩm mới nhất
        List<Product> top10Products = productService.findTop10Latest();
        req.setAttribute("top10Products", top10Products);

        req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
    }
}