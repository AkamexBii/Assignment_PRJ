<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update user</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            body{
                background: #136a8a;  /* fallback for old browsers */
                background: -webkit-linear-gradient(to right, #267871, #136a8a);  /* Chrome 10-25, Safari 5.1-6 */
                background: linear-gradient(to right, #267871, #136a8a); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

            }

            form {
                background: #8e9eab;  /* fallback for old browsers */
                background: -webkit-linear-gradient(to right, #eef2f3, #8e9eab);  /* Chrome 10-25, Safari 5.1-6 */
                background: linear-gradient(to right, #eef2f3, #8e9eab); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
            }
        </style>
    </head>
    <jsp:useBean id="rd" class="dal.RoleDAO" />
    <body>
        <div class="root relative">
            <div class="back-profile mt-6 ml-6">
                <a href="managerUser.jsp" class="text-3xl">
                    <i class="fa-solid fa-arrow-left text-black"></i> <span class="text-black">Manage User</span>
                </a>
            </div>
            <center>
                <form action="update-user" method="post" class="max-w-3xl border-2 border-gray-400 rounded pb-10 shadow-2xl">
                    <table>
                        <tr class="h-10">
                            <th colspan="4">
                                <h1 class="text-5xl m-5">Update User</h1>
                            </th>
                        </tr>
                        <tr class="h-10 text-lg">
                            <td colspan="2">Username: </td>
                            <td colspan="2">
                                <input type="text" readonly="" class="border-2 rounded w-full px-2" name="username" value="${requestScope.user.getUsername()}"/>
                            </td>
                        </tr>
                        <tr class="h-10 text-lg">
                            <td colspan="2">First Name: </td>
                            <td colspan="2">
                                <input type="text" class="border-2 rounded w-full px-2" name="fName" value="${requestScope.user.getFirstName()}"/>
                            </td>
                        </tr>
                        <tr class="h-10 text-lg">
                            <td colspan="2">Last Name: </td>
                            <td colspan="2">
                                <input type="text" class="border-2 rounded w-full px-2" name="lName" value="${requestScope.user.getLastName()}"/>
                            </td>
                        </tr>
                        <tr class="h-10 text-lg">
                            <td colspan="2">Email: </td>
                            <td colspan="2">
                                <input type="text" class="border-2 rounded w-full px-2" name="email" value="${requestScope.user.getEmail()}"/>
                            </td>
                        </tr>
                        <tr class="h-10 text-lg">
                            <td colspan="2">Phone: </td>
                            <td colspan="2">
                                <input type="text" class="border-2 rounded w-full px-2" name="phone" value="${requestScope.user.getPhone()}"/>
                            </td>
                        </tr>
                        <tr class="h-10 text-lg">
                            <td colspan="2">Role: </td>
                            <td colspan="2">
                                <select name="roleId" class="border-2 rounded w-full px-2">
                                    <c:forEach items="${rd.all}" var="r">
                                        <option value="${r.getId()}"} ${requestScope.user.getRole() == r.getId() ? "selected" : ""}>${r.getName()}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="submit" value="Update" class="w-full mt-2 py-2 bg-blue-700 rounded cursor-pointer text-white hover:bg-blue-600"/>         
                            </td>
                        </tr>
                        
                        <c:if test="${requestScope.updateMsg != null}">
                            <tr class="h-10 text-base">
                                <td colspan="4" class="text-green-600">
                                    ${requestScope.updateMsg}
                                </td>
                            </tr>
                        </c:if>
                    </table>
                </form>
            </center>
        </div>
    </body>
</html>
