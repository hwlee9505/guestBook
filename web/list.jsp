<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="guestbook.service.GetMessageListService" %>
<%@ page import="guestbook.service.MessageListView" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String pageNumberStr = request.getParameter("page");
    int pageNumber = 1;
    if (pageNumberStr != null) {
        pageNumber = Integer.parseInt(pageNumberStr);
    }

    GetMessageListService messageListService =
            GetMessageListService.getInstance();
    MessageListView viewData =
            messageListService.getMessageList(pageNumber);
%>
<c:set var="viewData" value="<%= viewData %>"/>
<html>
<head>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com//bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
    <title>방명록 메시지 목록</title>
</head>
<body>

    <form action="writeMessage.jsp" method="post">
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">이름: </span>
            </div>
            <input type="text" name="guestName" class="form-control" placeholder="Username">
        </div>

        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">암호: </span>
            </div>
            <input type="password" name="password" class="form-control" placeholder="Password">
        </div>

        메시지: <textarea name="message" cols="30" rows="3"></textarea> <br>
        <input type="submit" value="메시지 남기기"/>
    </form>
<hr>
<c:if test="${viewData.isEmpty()}">
    등록된 메시지가 없습니다.
</c:if>

<c:if test="${!viewData.isEmpty()}">
    <table class="table table-dark table-hover table-striped">
        <c:forEach var="message" items="${viewData.messageList}">
            <tr>
                <td>
                    메시지 번호: ${message.id} <br/>
                    손님 이름: ${message.guestName} <br/>
                    메시지: ${message.message} <br/>
                    <a href="confirmDeletion.jsp?messageId=${message.id}">[삭제하기]</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <c:forEach var="pageNum" begin="1" end="${viewData.pageTotalCount}">
        <a href="list.jsp?page=${pageNum}">[${pageNum}]</a>
    </c:forEach>

</c:if>
</body>
</html>