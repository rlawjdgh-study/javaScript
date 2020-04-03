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
	
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> REPLY 
					<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
				</div> 
				<div class="panel-body">
					<ul class="chat"></ul>
				</div> 
				<div class="panel-footer"></div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label>
						<input class="form-control" name="reply" value="New Reply!!!!">
					</div>
					<div class="form-group">
						<label>Replyer</label>
						<input class="form-control" name="replyer" value="replyer">
					</div>
					<div class="form-group">
						<label>Reply Date</label>
						<input class="form-control" name="replyDate" value="">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-warning" id="modalModBtn">Modify</button>
						<button type="button" class="btn btn-danger" id="modalRemoveBtn">Remove</button>
						<button type="button" class="btn btn-primary" id="modalRegisterBtn">Register</button>
						<button type="button" class="btn btn-default" id="modalCloseBtn">Close</button>
					</div> 
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
			
			var bnoValue = '<c:out value="${board.bno}"/>';
			var replyUL = $(".chat");
			showList(1);
			
			function showList(page) {
				 
			    replyService.getList({
			    	bno : bnoValue,
			    	page : page|| 1 
			    }, function(replyCnt, list) {
			      
			    	if(page == -1) {
			    		pageNum == Math.ceil(replyCnt/10.0);
			    		showList(pageNum);
			    		return;
			    	}
			    	
					var str="";
				    if(list == null || list.length == 0) {
						return;
				    }
				     
				    for (var i = 0, len = list.length || 0; i < len; i++) {
				      str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				      str +="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
				      str +="    <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
				      str +="<p>"+list[i].reply+"</p></div></li>";  
					}
			      
			     	replyUL.html(str);
			     	showReplyPage(replyCnt); 
		     	});
			 }
			
			var modal = $(".modal");
			var modalInputReply = modal.find("input[name='reply']");
			var modalInputReplyer = modal.find("input[name='replyer']");
			var modalInputReplyDate = modal.find("input[name='replyDate']");
			
			var modalModBtn = $("#modalModBtn");
			var modalRemoveBtn = $("#modalRemoveBtn");
			var modalRegisterBtn = $("#modalRegisterBtn");
			
			$("#addReplyBtn").on("click", function(e) {
				
				modal.find("input").val("");
				modalInputReplyDate.closest("div").hide();
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalRegisterBtn.show();
				
				$(".modal").modal("show");
			});
			
			
			modalRegisterBtn.on("click", function(e) {
				
				var reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
				};
				
				replyService.add(reply, function(result) {
					modal.find("input").val("");
			        modal.modal("hide"); 
			         
			        showList(-1);  
				});
			}); 
			
			$(".chat").on("click", "li", function(e) {
				var rno = $(this).data("rno");
				
				replyService.get(rno, function(reply){
					
					modalInputReply.val(reply.reply);
					modalInputReplyer.val(reply.replyer);
					modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
					modal.data("rno", reply.rno);
					
					modal.find("button[id != 'modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					
					$(".modal").modal("show");
				})
			});
			
			modalModBtn.on("click", function(e) {
				
				var reply = {
					rno : modal.data("rno"),
					reply : modalInputReply.val()	
				};
				
				replyService.update(reply, function(result) {
					modal.modal("hide");
					showList(1); 
				});
			});
			
 			
			var pageNum = 1;
			var replyPageFooter = $(".panel-footer");
			
			function showReplyPage(replyCnt) {
				 
				var endNum = Math.ceil(pageNum / 10.0) * 10;
				var startNum = endNum - 9;
				var prev = startNum != 1;
				var next = false;
				
				if(endNum * 10 >= replyCnt) {
					endNum = Math.ceil(replyCnt/10.0);
				}
				
				if(endNum * 10 < replyCnt) {
					next = true;
				}
				
				var str = "<ul class='pagination pull-right'>";
				
				if(prev) {
					str += "<li class='page-item'><a class='page-link' href='"+(startNum - 1)+"'>Previous</a></li>";
				}
				
				for(var i = startNum; i <= endNum; i++) {
					
					var active = pageNum == i ? "active" : "";
					str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
				} 
				
				if(next) { 
					str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
				}
				str += "</ul>";
				str += "</div>";
				
				replyPageFooter.html(str);
			}
			
			replyPageFooter.on("click", "li a", function(e) {
				e.preventDefault();
				
				var targetPageNum = $(this).attr("href");
				pageNum = targetPageNum;
				 
				showList(pageNum);
			});  
			
			
			modalModBtn.on("click", function(e) {
				
				var reply = {
					rno : modal.data("rno"),
					reply : modalInputReply.val()
				};
				
				replyService.update(reply, function(result) {
					modal.modal("hide");
					showList(pageNum);
				});
			});
			
			modalRemoveBtn.on("click", function(e) { 
				
				var rno = modal.data("rno");
				
				replyService.remove(rno, function(result) {
					
					modal.modal("hide");
					showList(pageNum);
				});
			}); 
			
		});
	</script>
	
	
<%@include file="../includes/footer.jsp"%>