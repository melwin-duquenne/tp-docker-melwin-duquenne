import { BrowserRouter as Router, Routes, Route, NavLink } from 'react-router-dom'; // Import de React Router
import Login from './Authentification/login';
import Dashboard from './index/Dashboard';
import RegisterForm from './Authentification/register';
import Tests from './index/test';


const App = () => {
  return (
    <Router>
      <div>
        <h1>Mon Application</h1>

        <nav>
          <ul>
            <li>
              <NavLink to="/">Login</NavLink>
            </li>
            <li>
              <NavLink to="/register">register</NavLink>
            </li>
            <li>
              <NavLink to="/dashboard">Dashboard</NavLink>
            </li>
            <li>
              <NavLink to="/test">test</NavLink>
            </li>
          </ul>
        </nav>
        <Routes>
          <Route path="/" element={<Login />} />
          <Route path="/register" element={<RegisterForm />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path='/test' element={<Tests/>}/>
        </Routes>
      </div>
    </Router>
  );
};

export default App;
