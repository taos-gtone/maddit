package com.maddit.service;

import com.maddit.mapper.CommonMapper;
import com.maddit.vo.ComCodeDtlVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommonServiceImpl implements CommonService {

    @Autowired
    private CommonMapper commonMapper;

    @Override
    public List<ComCodeDtlVO> getCodeList(String codeGrpId) {
        return commonMapper.selectCodeListByGrp(codeGrpId);
    }
}
