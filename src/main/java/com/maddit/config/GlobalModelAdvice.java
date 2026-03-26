package com.maddit.config;

import com.maddit.service.CommonService;
import com.maddit.vo.ComCodeDtlVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.ui.Model;

import java.util.List;

@ControllerAdvice(basePackages = "com.maddit.controller")
public class GlobalModelAdvice {

    @Autowired
    private CommonService commonService;

    @ModelAttribute
    public void addProgramCategories(Model model) {
        List<ComCodeDtlVO> progCategories = commonService.getCodeList("C014");
        model.addAttribute("progCategories", progCategories);
    }
}
