package com.aza.myapp.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.ReportVO;
import com.aza.myapp.repository.ReportDAO;

@Service
public class ReportServiceImpl implements ReportService{
	@Inject
	private ReportDAO rdao;

	@Override
	public int insert(ReportVO rvo) {
		return rdao.insert(rvo);
	}

	@Override
	public int isReport(ReportVO rvo) {
		return rdao.isReport(rvo);
	}

	@Override
	public int reportCount(ReportVO rvo) {
		return rdao.reportCount(rvo);
	}
}
