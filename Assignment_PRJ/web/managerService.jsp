<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Managment Services</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <jsp:useBean id="s" class="dal.ServiceDAO" />
    <body>
        <div class="root h-full bg-slate-300 relative">
            <div class="h-16 bg-zinc-900 w-screen py-3 px-8 fixed z-50 top-0" id="header">
                <div class="nav flex h-full justify-between">
                    <div class="logo basis-2/6 flex justify-center items-center"><span
                            class="block text-slate-100 text-3xl">GamingGear</span></div>
                    <div class="menu basis-3/6">
                        <ul class="flex justify-between items-center h-full text-slate-300">
                            <li><a href="home.jsp"
                                   class="hover:text-slate-100 relative after:absolute after:bottom-0 after:left-0 after:bg-slate-50 after:h-0.5 after:w-0 hover:after:w-full after:transition-all after:ease-in-out after:duration-300 uppercase">Home</a>
                            </li>
                            <c:if test="${sessionScope.user == null}">
                                <li><a href="login.jsp"
                                       class="hover:text-slate-100 relative after:absolute after:bottom-0 after:left-0 after:bg-slate-50 after:h-0.5 after:w-0 hover:after:w-full after:transition-all after:ease-in-out after:duration-300">Login</a>
                                </li>
                            </c:if>
                            <c:if test="${sessionScope.user != null}">
                                <li class="user">
                                    <a class="cursor-pointer">Hello ${sessionScope.user.getFirstName()} <img
                                            src="./image/arrowDown.png" class="inline h-4" /></a>
                                    <ul
                                        class="user-menu hidden absolute top-16 w-36 text-black shadow-2xl bg-white">
                                        <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white">
                                            Profile
                                        </li>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white" onclick="goManagement()">
                                                Management
                                            </li>                                            
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white" onclick="goChart()">
                                                Chart
                                            </li>                                            
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goServiceManager()">
                                                Service(Admin)
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 2}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white" onclick="goOrder()">
                                                View Orders
                                            </li>                                            
                                        </c:if>
                                        <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white">
                                            Logout
                                        </li>
                                    </ul>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                    <div class="cart flex basis-1/6 ml-16 flex items-center">
                        <a href="cart.jsp" class="h-full">
                            <img src="./image/cart.png" alt="cart" class="h-full" />
                        </a>
                        <span class="text-slate-100 mx-2">CART</span>
                        <span class="text-slate-100 rounded-xl bg-orange-700 px-2 py-1">${sessionScope.cart != null ? sessionScope.cart.getList().size() : 0}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-24 flex justify-center">
            <h1 class="font-bold text-3xl">Service Managment</h1>
        </div>
        <form class="flex justify-between" action="create-service" method="get">
            <div></div>
            <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Add</button>
        </form>
        <section class="container mx-auto p-6 font-mono">
            <div class="w-full mb-8 overflow-hidden rounded-lg shadow-lg">
                <div class="w-full overflow-x-auto">
                    <table class="w-full">
                        <thead>
                            <tr class="text-md font-semibold tracking-wide text-left text-gray-900 bg-gray-100 uppercase border-b border-gray-600">
                                <th class="px-4 py-3">ID</th>
                                <th class="px-4 py-3">Name</th>
                                <th class="px-4 py-3">Price</th>
                                <th class="px-4 py-3">Description</th>
                                <th class="px-4 py-3">Image</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white">
                            <c:forEach items="${s.all}" var="sv">
                                <tr class="text-gray-700">
                                    <td class="px-4 py-3 border">
                                        ${sv.getId()}
                                    </td>
                                    <td class="px-4 py-3 border">
                                        ${sv.getName()}
                                    </td>
                                    <td class="px-4 py-3 text-ms font-semibold border">${sv.getPrice()}</td>
                                    <td class="px-4 py-3 text-xs border">
                                        ${sv.getDescription()}
                                    </td>
                                    <td class="px-4 py-3 text-sm border">
                                        <img style="width: 60px; height: 60px; object-fit: cover" alt="img" src="${sv.getImage()}"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

    </body>
</html>
<script type="text/javascript" src="/Project1/js/header.js"></script>