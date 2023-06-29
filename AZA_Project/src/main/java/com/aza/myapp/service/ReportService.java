package com.aza.myapp.service;

import com.aza.myapp.domain.ReportVO;

public interface ReportService {

	int insert(ReportVO rvo);

	int isReport(ReportVO rvo);

	int reportCount(ReportVO rvo);

}
