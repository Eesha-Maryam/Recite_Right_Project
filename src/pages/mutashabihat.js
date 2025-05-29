import React from 'react';
import Header from '../components/header'; // Adjust path as needed

const Mutashabihat = () => {
  return (
    <div className="mutashabihat-container">
      {/* Header will automatically appear with white bg and olive green border */}
      <Header />
      
      {/* Your dashboard content */}
      <main className="mutashabihat-content">
        <h1>Mutashabihat</h1>
        {/* ... rest of your dashboard content ... */}
      </main>
    </div>
  );
};

export default Mutashabihat;