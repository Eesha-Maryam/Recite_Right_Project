// src/pages/VerifyEmailPage.jsx
import React, { useEffect, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import axios from 'axios';

const VerifyEmailPage = () => {
  const [searchParams] = useSearchParams();
  const [message, setMessage] = useState('');
  const token = searchParams.get('token');

  useEffect(() => {
    const verifyEmail = async () => {
      try {
        const response = await axios.post('http://localhost:5000/v1/auth/verify-email', {
          token,
        });
        setMessage('Email successfully verified! You can now log in.');
      } catch (error) {
        setMessage(error.response?.data?.message || 'Verification failed.');
      }
    };

    if (token) verifyEmail();
    else setMessage('No token provided.');
  }, [token]);

  return <div>{message}</div>;
};

export default VerifyEmailPage;
