<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<%@include file="../includes/header.jsp"%>
<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>  -->
  	
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
	
	<!-- Modal 추가 --> 
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				</div>
				<div class="modal-body">처리가 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-default">Save changes</button>
				</div> 
			</div>
		</div>
	</div>
	<!-- /.modal -->
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			
			var result = '<c:out value="${result}"/>'; // register 번호
			checkModal(result);
			
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
		
		
		function checkModal(result) {
			
			if(result == '') { 
				return; 
			}     
			if(result > 0) { 
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}  
			  
			$("#myModal").modal("show");
		}  
		
	</script> 


<%@include file="../includes/footer.jsp"%>