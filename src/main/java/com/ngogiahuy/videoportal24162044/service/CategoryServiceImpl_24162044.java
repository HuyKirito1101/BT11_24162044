package com.ngogiahuy.videoportal24162044.service;
import com.ngogiahuy.videoportal24162044.entity.Category_24162044;
import com.ngogiahuy.videoportal24162044.repository.CategoryRepository_24162044;
import java.util.List;
public class CategoryServiceImpl_24162044 implements CategoryService_24162044 { private final CategoryRepository_24162044 repository=new CategoryRepository_24162044(); public List<Category_24162044> getAllCategories(){return repository.findAll();} public List<Category_24162044> getActiveCategories(){return repository.findActive();} }
