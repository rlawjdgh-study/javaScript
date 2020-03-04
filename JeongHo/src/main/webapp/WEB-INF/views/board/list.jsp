<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<%@include file="../includes/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  	
	<div class="row">  
		<div class="col-lg-12">
			<h1 class="page-header">Tables</h1>
		</div>
	</div>
	
	<div class="row"> 
		<div class="col-lg-12"> 
			<div class="panel panel-default">
				<div class="panel-heading">DataTables Advanced Tables</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="table-responsive">
						<table class="table table-striped table-bordered table-hover" id="dataTables-example">
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>수정일</th>
								</tr> 
							</thead>
							<tbody id="boardList"></tbody>
						</table>
					</div>
				</div>
			</div>
		</div> 
	</div>
	
	<script type="text/javascript">
	
	$(document).ready(function() {
			
		$.getJSON({
			url : "/board/getList", 
			type : "get",   
			success : function(result) {
				var str = ""; 
 				 
				// oralce 한정 대문자
				$.each(result, function(i) {
					str += "<tr>"; 
					str += "<td>"+result[i].BNO+"</td>"; 
					str += "<td>"+result[i].TITLE+"</td>"; 
					str += "<td>"+result[i].WRITER+"</td>";
					str += "<td>"+result[i].REGDATE+"</td>";
					str += "<td>"+result[i].UPDATEDATE+"</td>";
					str += "</tr>";      
					
				});  
				  
				$("#boardList").html(str); 
			} 	  
		});
	
	 
	});
	</script>


<%@include file="../includes/footer.jsp"%>