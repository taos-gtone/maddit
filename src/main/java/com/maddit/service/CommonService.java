package com.maddit.service;

import com.maddit.vo.ComCodeDtlVO;

import java.util.List;

public interface CommonService {

    List<ComCodeDtlVO> getCodeList(String codeGrpId);
}
