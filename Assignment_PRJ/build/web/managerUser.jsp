<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage User</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>

    <jsp:useBean id="ud" class="dal.UserDAO" />
    <jsp:useBean id="rd" class="dal.RoleDAO" />
    <body>
        <div class="root">
            <div class="h-16 bg-zinc-900 w-screen py-3 px-8 fixed z-50 top-0" id="header">
                <div class="nav flex h-full justify-between">
                    <div class="logo basis-2/6 flex justify-center items-center"><span
                            class="block text-slate-100 text-3xl">Smart Beauty</span></div>
                    <div class="menu basis-3/6">
                        <ul class="flex justify-between items-center h-full text-slate-300">
                            <li><a href="home.jsp"
                                   class="hover:text-slate-100 relative after:absolute after:bottom-0 after:left-0 after:bg-slate-50 after:h-0.5 after:w-0 hover:after:w-full after:transition-all after:ease-in-out after:duration-300 uppercase">Home</a>
                            </li>
                            <li><a href="product.jsp"
                                   class="hover:text-slate-100 relative after:absolute after:bottom-0 after:left-0 after:bg-slate-50 after:h-0.5 after:w-0 hover:after:w-full after:transition-all after:ease-in-out after:duration-300 uppercase">Products</a>
                            </li>
                            <li><a href="service.jsp"
                                   class="hover:text-slate-100 relative after:absolute after:bottom-0 after:left-0 after:bg-slate-50 after:h-0.5 after:w-0 hover:after:w-full after:transition-all after:ease-in-out after:duration-300 uppercase">Service</a>
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
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goManagement()">
                                                Management
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goChart()">
                                                Chart
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goServiceManager()">
                                                Service(Admin)
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goUserManage()">
                                                Manage User
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 2}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goOrder()">
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
                        <span class="text-slate-100 rounded-xl bg-orange-700 px-2 py-1">${sessionScope.cart != null
                                                                                          ? sessionScope.cart.getList().size() + sessionScope.cart.getListService().size() : 0}</span>
                    </div>
                </div>
            </div>

            <form action="search-user" class="mt-20 mb-20">
                <div class="mb-6">
                    <h1 class="text-3xl font-bold" style="text-align: center;">User managment</h1>
                </div>
                <div class="flex justify-center">
                    <div class="w-7/12">   
                        <label for="default-search" class="mb-2 text-sm font-medium sr-only">Search</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z"/>
                                </svg>
                            </div>
                            <input type="search" value="${requestScope.search}" name="search" id="default-search" class="block w-full p-4 pl-10 text-sm border rounded-lg focus:ring-blue-500 focus:border-blue-500" placeholder="Search Mockups, Logos...">
                            <button type="submit" class="text-white absolute right-2.5 bottom-2.5 bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Search</button>
                        </div>
                    </div>
                </div>
                <c:if test="${requestScope.msgSuccess != null}">
                    <div class="flex justify-center">
                        <span class="text-xl text-green-600">${requestScope.msgSuccess}</span>
                    </div>
                </c:if>
                <c:if test="${requestScope.msgError != null}">
                    <div class="flex justify-center">
                        <span class="text-xl text-red-600">${requestScope.msgError}</span>
                    </div>
                </c:if>
                <div class="flex flex-col" style="align-items: center;">
                    <div class="overflow-x-auto sm:-mx-6 lg:-mx-8 w-10/12">
                        <div class="inline-block min-w-full py-2 sm:px-6 lg:px-8">
                            <div class="overflow-hidden">
                                <table class="min-w-full text-left text-sm font-light">
                                    <thead
                                        class="border-b bg-white font-medium">
                                        <tr>
                                            <th scope="col" class="px-6 py-4">ID</th>
                                            <th scope="col" class="px-6 py-4">Full Name</th>
                                            <th scope="col" class="px-6 py-4">Username</th>
                                            <th scope="col" class="px-6 py-4">Email</th>
                                            <th scope="col" class="px-6 py-4">Phone</th>
                                            <th scope="col" class="px-6 py-4">Role</th>
                                            <th scope="col" class="px-6 py-4">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${requestScope.data == null}">
                                            <c:forEach items="${ud.getAllUserWithoutCurrent(sessionScope.user.getUserId())}" var="u">
                                                <tr
                                                    class="border-b bg-neutral-100">
                                                    <td class="whitespace-nowrap px-6 py-4 font-medium">${u.getUserId()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${u.getLastName()} ${u.getFirstName()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${u.getUsername()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${u.getEmail()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${u.getPhone()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${rd.getRoleById(u.getRole()).getName()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">
                                                        <div class="flex">
                                                            <a href="update-user?userId=${u.getUserId()}" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                                                Update
                                                            </a>
                                                            <form action="delete-user" method="post">
                                                                <button type="button" onclick="doDeleteUser(${u.getUserId()})" class="focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900">
                                                                    Delete
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>    
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${requestScope.data != null}">
                                            <c:forEach items="${requestScope.data}" var="u">
                                                <tr
                                                    class="border-b bg-neutral-100 item-user">
                                                    <td class="whitespace-nowrap px-6 py-4 font-medium">${u.getUserId()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${u.getLastName()} ${u.getFirstName()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${u.getUsername()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${u.getEmail()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${u.getPhone()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">${rd.getRoleById(u.getRole()).getName()}</td>
                                                    <td class="whitespace-nowrap px-6 py-4">
                                                        <div class="flex">
                                                            <a href="update-user?userId=${u.getUserId()}" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                                                Update
                                                            </a>
                                                            <form action="delete-user" method="post">
                                                                <button type="button" onclick="doDeleteUser(${u.getUserId()})" class="focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900">
                                                                    Delete
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>    
                                            </c:forEach>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
<!--                <div class="flex justify-center">
                    <div class="flex items-center justify-between border-t border-gray-200 bg-white px-4 py-3 sm:px-6 w-10/12">
                        <div class="flex flex-1 justify-between sm:hidden">
                            <a href="#" class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Previous</a>
                            <a href="#" class="relative ml-3 inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Next</a>
                        </div>
                        <div class="hidden sm:flex sm:flex-1 sm:items-center sm:justify-between">
                            <div>
                                <p class="text-sm text-gray-700">
                                    Showing
                                    <span class="font-medium">1</span>
                                    to
                                    <span class="font-medium">5</span>
                                    of
                                    <span class="font-medium total"></span>
                                    results
                                </p>
                            </div>
                            <div>
                                <nav class="isolate inline-flex -space-x-px rounded-md shadow-sm" aria-label="Pagination">
                                    <a href="#" class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
                                        <span class="sr-only">Previous</span>
                                        <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                        <path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z" clip-rule="evenodd" />
                                        </svg>
                                    </a>
                                    <a href="#" aria-current="page" class="relative z-10 inline-flex items-center bg-indigo-600 px-4 py-2 text-sm font-semibold text-white focus:z-20 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">1</a>
                                    <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">2</a>
                                    <a href="#" class="relative hidden items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0 md:inline-flex">3</a>
                                    <span class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-700 ring-1 ring-inset ring-gray-300 focus:outline-offset-0">...</span>
                                    <a href="#" class="relative hidden items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0 md:inline-flex">8</a>
                                    <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">9</a>
                                    <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">10</a>
                                    <a href="#" class="relative inline-flex items-center rounded-r-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
                                        <span class="sr-only">Next</span>
                                        <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                        <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z" clip-rule="evenodd" />
                                        </svg>
                                    </a>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>-->
            </form>
        </div>
    </body>
</html>

<script type="text/javascript" src="/Project1/js/header.js"></script>
<script>
                                                                    function doDeleteUser(userId) {
                                                                        const form = document.createElement('form');
                                                                        form.action = 'delete-user'; // Set the form action
                                                                        form.method = 'post'; // Set the form method

                                                                        const nameInput = document.createElement('input');
                                                                        nameInput.type = 'text';
                                                                        nameInput.name = 'userId';
                                                                        nameInput.value = userId;
                                                                        form.appendChild(nameInput);

                                                                        const confirm = window.confirm('Confirm delete user');

                                                                        if (confirm) {
                                                                            // Submit the form
                                                                            document.body.appendChild(form); // Append the form to the document body
                                                                            form.submit();
                                                                        }
                                                                    }

//                                                                    const userData = document.querySelectorAll('.item-user')
//                                                                    const total = document.querySelector('.total')
//                                                                    total.innerText = userData.length
</script>