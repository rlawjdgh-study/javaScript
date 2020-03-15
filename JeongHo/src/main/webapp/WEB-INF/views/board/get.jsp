<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>      

<%@include file="../includes/header.jsp"%>
	
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Read</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default"> 
				<div class="panel-heading">Board Read Page</div>
				<div class="panel-body">
					<div class="form-group">
						<label>Bno</label>
						<input class="form-control" name="bno" value="<c:out value="${board.bno}"/>" readonly="readonly">
					</div>
					<div class="form-group">
						<label>Title</label>
						<input class="form-control" name="title" value="<c:out value="${board.title}"/>" readonly="readonly">
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>  
					</div>  
					<div class="form-group">
						<label>Writer</label>
						<input class="form-control" name="writer" value="<c:out value="${board.writer}"/>" readonly="readonly">
					</div>
					
					<button class="btn btn-default" data-oper="modify">Modify</button>
					<button class="btn btn-info" data-oper="list">List</button>	
				</div>  
			</div>
		</div>
	</div>
	
	<form id="operForm" action="/board/modify" method="get">
		<input type="hidden" id="bno" name="bno" value="<c:out value="${board.bno}"/>">
		<input type="hidden" id="pageNum" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
		<input type="hidden" id="amount" name="amount" value="<c:out value="${cri.amount}"/>">
		<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
		<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
	</form>  
	
	<script type="text/javascript" src="/resources/js/reply.js"></script>
	
	<script type="text/javascript">
		var csrfHeaderName ="${_csrf.headerName}"; 
		var csrfTokenValue="${_csrf.token}";
		var parameterName =  "${_csrf.parameterName}";
	
		$(document).ajaxSend(function(e, xhr, options) { 
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
		});
	
		$(document).ready(function() {
			
			var operForm = $("#operForm");
			$("button[data-oper='modify']").on("click", function(e) {
				operForm.attr("action", "/board/modify").submit();
			}); 
			
			$("button[data-oper='list']").on("click", function(e) {
				
				operForm.find("#bno").remove();
				operForm.attr("action", "/board/list"); 
				operForm.submit(); 
			}); 
		});
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		// 임시 ↓
		
		replyService.add({
			reply:"JS Test", 
			replyer : "tester", 
			bno : bnoValue
		}, function(result) {
			alert("RESULT : " + result);
		});  
		
		replyService.getList({
			bno : bnoValue,
			page : 1
		}, function(list) {
			
			for(var i = 0, len = list.length||0; i < len; i++) {
				console.log(list[i]);
			}
		});  
		
		replyService.remove(1, function(count) {
			
			if(count == "success") {
				alert("REMOVE"); 
			}
		}, function(err) {
			alert("ERROR...");
		});
		
		replyService.update({
			rno : 2,
			bno : bnoValue,
			reply : "Modified Reply...."
		}, function(result) {
			alert("수정완료...");		
		});
		
	</script>
	
	
<%@include file="../includes/footer.jsp"%>