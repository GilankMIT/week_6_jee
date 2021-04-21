package controller;

import data.CryptoCoinData;
import model.CryptoCoin;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class HomeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        String view = "templates/index.jsp";
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(view);

        CryptoCoinData cryptoCoinData = new CryptoCoinData();
        List<CryptoCoin> cryptoCoinList = cryptoCoinData.getCryptoCoinDataList();

        HttpSession httpSession = request.getSession();
        List<String> cryptoWatchlist = (List<String>) httpSession.getAttribute("crypto-coin-watchlist");

        request.setAttribute("coins", cryptoCoinList);
        request.setAttribute("crypto-coin-watchlist", cryptoWatchlist);
        requestDispatcher.forward(request, response);
    }
}
