# 🎬 BookIt - Premium Movie Ticketing Platform

**BookIt** is a full-stack, production-ready movie ticketing web application. It delivers a modern, rich aesthetic combined with robust state management and intelligent AI integrations. From dynamic seat selection and real-time checkout flows to AI-powered movie insights, BookIt serves as a comprehensive clone of enterprise theater software with premium styling.

---

## 🌟 Key Features

*   **Intelligent Booking Pipeline:** A seamless, multi-stage checkout process. Users dynamically select their location, premiere date, movie, screen quality (2D/3D), hall, specific seats, and final payment method.
*   **AI-Powered Movie Insights:** Directly integrates with Google's **Gemini AI** (`gemini-flash-latest`) to generate deep analysis, trivia, and reviews on any movie to help users decide what to watch.
*   **State Management Engine:** Utilizes **Redux Toolkit** to strictly manage complex cross-page states (Cart state, Authentication barriers, and Location configurations).
*   **Interactive UI/UX:** Styled using pure CSS with dynamic hover effects, smooth micro-interactions, dark glassmorphism modals, and responsive grids.
*   **Full Admin Dashboard:** A protected administrative panel allowing theater managers to view consolidated sales, track tickets, and monitor revenue in real-time.
*   **Secure & Robust Backend:** Built on Node.js/Express with strict MySQL strict mode handling, custom aggregate queries, and automated schema seeding. Let the backend handle the heavy lifting while React renders the polish!

---

## 🛠️ Technology Stack

**Frontend**
*   **React 18** (Bootstrapped with Vite for instant server reload)
*   **Redux Toolkit** (Complex global state & prop-drilling elimination)
*   **React Router DOM** (Single Page Application routing)
*   **CSS3** (Custom Utility architecture, Flexbox/Grid systems)
*   **React Icons & Spinners** 

**Backend & Database**
*   **Node.js / Express.js**
*   **MySQL 8.x** (Using `mysql2` driver)
*   **Gemini AI API** (`@google/generative-ai`)
*   **Cors & JSON Body Parser**

---

## 🚀 Quick Setup (Local Development)

To run this application locally, you will need Node.js and a running MySQL instance (either local or cloud-hosted via Railway/Supabase).

### 1. Database Initialization
Create a MySQL database. Then run the included seeder pipeline to automatically generate all tables, relations, and mock data:
```bash
cd backend
npm install
# Ensure you configure your backend/.env first (see below)
npm run db:init
```

### 2. Environment Variables
Create a `.env` file in both `backend/` and `frontend/` using the following templates:

**`backend/.env`**
```env
PORT=7000
MYSQL_PUBLIC_URL=mysql://user:password@host:port/database_name
# (Alternatively, you can provide DB_HOST, DB_USER, DB_PASSWORD individually)
```

**`frontend/.env`**
```env
VITE_API_URL=http://localhost:7000
VITE_APP_GEMINI_API_KEY=your_gemini_api_key_here
```

### 3. Firing up the Servers
Open two terminals to start both the Vite Frontend and the Express Backend:

**Terminal 1 (Backend)**
```bash
cd backend
npm start
# Runs automatically on nodemon
```
**Terminal 2 (Frontend)**
```bash
cd frontend
npm install
npm run dev
# Starts your Vite lightning-fast server
```

---
