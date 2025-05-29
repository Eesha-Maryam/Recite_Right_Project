import React, { useEffect, useState } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import axios from 'axios';
import './signup.css'; // Reuse your existing styles

const EmailVerificationPage = () => {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const [message, setMessage] = useState('Verifying your email...');
  const [isSuccess, setIsSuccess] = useState(false);

  useEffect(() => {
    const token = searchParams.get('token');
    
    if (!token) {
      setMessage('Invalid verification link');
      return;
    }

    const verifyEmail = async () => {
      try {
        const response = await axios.get(`http://localhost:5000/v1/auth/verify-email?token=${token}`);
        
        if (response.status === 200) {
          setMessage('Email verified successfully!');
          setIsSuccess(true);
        }
      } catch (error) {
        console.error('Verification error:', error);
        setMessage(error.response?.data?.message || 'Email verification failed');
      }
    };

    verifyEmail();
  }, [searchParams]);

  return (
    <div className="dialog-overlay">
      <div className="dialog-box">
        <h3 className="dialog-heading">
          {isSuccess ? 'Success!' : 'Verification Status'}
        </h3>
        <p className="dialog-message">{message}</p>
        {isSuccess && (
          <button 
            className="dialog-button"
            onClick={() => navigate('/login')}
          >
            Go to Login
          </button>
        )}
      </div>
    </div>
  );
};

export default EmailVerificationPage;