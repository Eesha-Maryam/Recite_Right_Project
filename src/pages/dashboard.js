import React, { useState } from 'react';
import Header from '../components/header';
import './dashboard.css';

const Dashboard = () => {
  const [selectedMonth, setSelectedMonth] = useState('January');
  const months = [
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'
  ];

  return (
    <div className="dashboard-container">
      <Header />
      
      <main className="dashboard-main">
        <div className="dashboard-header">
          <h1 className="dashboard-title">Dashboard</h1>
          <p className="dashboard-subtitle">Here's your analytic details</p>
        </div>

        <div className="dashboard-cards">
          {/* Progress Rate Card */}
          <div className="dashboard-card">
            <div className="card-header">
              <h2 className="card-title">Progress Rate</h2>
              <div className="dropdown-container">
                <select 
                  className="month-dropdown"
                  value={selectedMonth}
                  onChange={(e) => setSelectedMonth(e.target.value)}
                >
                  {months.map(month => (
                    <option key={month} value={month}>{month}</option>
                  ))}
                </select>
              </div>
            </div>
            
            <div className="chart-container">
              <svg
                role="img"
                aria-label="Progress rate bar chart"
                viewBox="0 0 800 250"
                className="chart-svg"
              >
                {/* Y-axis lines */}
                <line x1="60" y1="220" x2="740" y2="220" className="axis" />
                <line x1="60" y1="170" x2="740" y2="170" className="axis" />
                <line x1="60" y1="120" x2="740" y2="120" className="axis" />
                <line x1="60" y1="70" x2="740" y2="70" className="axis" />
                <line x1="60" y1="20" x2="740" y2="20" className="axis" />

                {/* Y-axis labels */}
                <text x="20" y="225" className="label">0%</text>
                <text x="20" y="175" className="label">25%</text>
                <text x="20" y="125" className="label">50%</text>
                <text x="20" y="75" className="label">75%</text>
                <text x="20" y="25" className="label">100%</text>

                {/* Bars with increased spacing */}
                <rect x="100" y="70" width="40" height="150" className="bar" />
                <rect x="200" y="60" width="40" height="160" className="bar" />
                <rect x="300" y="130" width="40" height="90" className="bar" />
                <rect x="400" y="100" width="40" height="120" className="bar" />
                <rect x="500" y="20" width="40" height="200" className="bar" />
                <rect x="600" y="100" width="40" height="120" className="bar" />
                <rect x="700" y="100" width="40" height="120" className="bar" />

                {/* X-axis labels */}
                <text x="90" y="240" className="label">Session 1</text>
                <text x="190" y="240" className="label">Session 2</text>
                <text x="290" y="240" className="label">Session 3</text>
                <text x="390" y="240" className="label">Session 4</text>
                <text x="490" y="240" className="label">Session 5</text>
                <text x="590" y="240" className="label">Session 6</text>
                <text x="690" y="240" className="label">Session 7</text>
              </svg>
            </div>
          </div>

          {/* Scoreboard Card */}
          <div className="dashboard-card">
            <div className="card-header">
              <h2 className="card-title">Scoreboard</h2>
              <div className="dropdown-container">
                <select 
                  className="month-dropdown"
                  value={selectedMonth}
                  onChange={(e) => setSelectedMonth(e.target.value)}
                >
                  {months.map(month => (
                    <option key={month} value={month}>{month}</option>
                  ))}
                </select>
              </div>
            </div>
            
            <div className="chart-container">
              <svg
                role="img"
                aria-label="Scoreboard bar chart"
                viewBox="0 0 800 250"
                className="chart-svg"
              >
                {/* Y-axis lines */}
                <line x1="80" y1="220" x2="760" y2="220" className="axis" />
                <line x1="80" y1="170" x2="760" y2="170" className="axis" />
                <line x1="80" y1="120" x2="760" y2="120" className="axis" />
                <line x1="80" y1="70" x2="760" y2="70" className="axis" />
                <line x1="80" y1="20" x2="760" y2="20" className="axis" />

                {/* Y-axis labels */}
                <text x="20" y="225" className="label">0</text>
                <text x="20" y="175" className="label">25</text>
                <text x="20" y="125" className="label">50</text>
                <text x="20" y="75" className="label">75</text>
                <text x="20" y="25" className="label">100</text>

                {/* Bars with increased spacing */}
                <rect x="120" y="70" width="40" height="150" className="bar" />
                <rect x="220" y="120" width="40" height="100" className="bar" />
                <rect x="320" y="170" width="40" height="50" className="bar" />
                <rect x="420" y="100" width="40" height="120" className="bar" />
                <rect x="520" y="20" width="40" height="200" className="bar" />
                <rect x="620" y="90" width="40" height="130" className="bar" />
                <rect x="720" y="70" width="40" height="150" className="bar" />

                {/* Score labels */}
                <text x="215" y="110" className="score-orange">60 score</text>
                <text x="318" y="160" className="score-red">40 score</text>
                <text x="510" y="10" className="score-green">99.95 score</text>

                {/* X-axis labels */}
                <text x="125" y="240" className="label">Test 1</text>
                <text x="222" y="240" className="label">Test 2</text>
                <text x="322" y="240" className="label">Test 3</text>
                <text x="422" y="240" className="label">Test 4</text>
                <text x="522" y="240" className="label">Test 5</text>
                <text x="622" y="240" className="label">Test 6</text>
                <text x="722" y="240" className="label">Test 7</text>
              </svg>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
};

export default Dashboard;