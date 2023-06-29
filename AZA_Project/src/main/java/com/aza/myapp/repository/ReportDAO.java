package com.aza.myapp.repository;

import com.aza.myapp.domain.ReportVO;

public interface ReportDAO {

	int insert(ReportVO rvo);

	int isReport(ReportVO rvo);

	int reportCount(ReportVO rvo);

}
