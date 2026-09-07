package trungduc.vn.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import trungduc.vn.entity.Category;
import trungduc.vn.services.ICategoryService;
import trungduc.vn.services.impl.CategoryServiceImpl;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet(urlPatterns = {
    "/admin/categories",
    "/admin/category/add",
    "/admin/category/insert",
    "/admin/category/edit",
    "/admin/category/update",
    "/admin/category/delete"
})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ICategoryService categoryService = new CategoryServiceImpl();
    private static final String UPLOAD_DIRECTORY = "uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/admin/categories")) {
            List<Category> list = categoryService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryService.findById(id);
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                categoryService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();
        String uploadPath = req.getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        if (url.contains("/admin/category/insert")) {
            String categoryName = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status"));

            // Xử lý upload ảnh an toàn
            String finalFileName = "";
            try {
                Part filePart = req.getPart("images");
                if (filePart != null && filePart.getSize() > 0) {
                    String submittedName = filePart.getSubmittedFileName();
                    if (submittedName != null && !submittedName.trim().isEmpty()) {
                        String fileName = Paths.get(submittedName).getFileName().toString();
                        finalFileName = System.currentTimeMillis() + "_" + fileName;
                        filePart.write(uploadPath + File.separator + finalFileName);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            Category category = new Category();
            category.setCategoryname(categoryName);
            category.setImages(finalFileName);
            category.setStatus(status);

            categoryService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");

        } else if (url.contains("/admin/category/update")) {
            int id = Integer.parseInt(req.getParameter("categoryid"));
            String categoryName = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status"));
            String oldImage = req.getParameter("oldImage");

            // Xử lý upload ảnh mới nếu có chọn
            String finalFileName = oldImage;
            try {
                Part filePart = req.getPart("images");
                if (filePart != null && filePart.getSize() > 0) {
                    String submittedName = filePart.getSubmittedFileName();
                    if (submittedName != null && !submittedName.trim().isEmpty()) {
                        String fileName = Paths.get(submittedName).getFileName().toString();
                        finalFileName = System.currentTimeMillis() + "_" + fileName;
                        filePart.write(uploadPath + File.separator + finalFileName);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            Category category = new Category();
            category.setCategoryid(id);
            category.setCategoryname(categoryName);
            category.setImages(finalFileName);
            category.setStatus(status);

            categoryService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }
}