package com.maddit.mapper;

import com.maddit.vo.ComCodeDtlVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CommonMapper {

    List<ComCodeDtlVO> selectCodeListByGrp(@Param("codeGrpId") String codeGrpId);
}
