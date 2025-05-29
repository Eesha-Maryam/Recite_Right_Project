import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './forgot-password.css';

const ForgotPassword = () => {
  const [email, setEmail] = useState('');
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [focusedField, setFocusedField] = useState(null);
  const [success, setSuccess] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    setError('');
  
    try {
      // Remove any whitespace from email
      const trimmedEmail = email.trim();
      
      const response = await axios.post('http://localhost:5000/v1/auth/forgot-password', {
        email: trimmedEmail
      }, {
        headers: {
          'Content-Type': 'application/json'
        },
        validateStatus: (status) => status === 204 || status === 404
      });

      // For 204 No Content, we won't get response data
      if (response.status === 204) {
        setSuccess(true);
      } else {
        // This will only trigger for 404 status due to validateStatus
        setError('Email not found. Please check your email address.');
      }
    } catch (error) {
      if (error.response) {
        // Server responded with a status other than 2xx/404
        setError(error.response.data?.message || 'Something went wrong. Please try again.');
      } else if (error.request) {
        // Request was made but no response received
        setError('Network error. Please check your connection.');
      } else {
        // Something happened in setting up the request
        setError('An error occurred. Please try again.');
      }
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="forgot-container">
      <div className="form-center-container">
        <div className="forgot-card">
          {success ? (
            <div className="success-message">
              <h2 className="success-title">Check Your Email</h2>
              <p className="success-text">If an account exists for {email}, you'll receive a password reset link.</p>
              <button 
                onClick={() => navigate('/login')}
                className="forgot-button"
              >
                Back to Login
              </button>
            </div>
          ) : (
            <>
              <h2 className="forgot-title">Forgot Password</h2>
              <p>Enter your email address and we'll send you a link to reset your password.</p>
              <form onSubmit={handleSubmit} className="forgot-form">
                <div className="input-group">
                  <input 
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    onFocus={() => setFocusedField('email')}
                    onBlur={() => setFocusedField(null)}
                    placeholder="Enter your email"
                    className={`input-field ${focusedField === 'email' ? 'input-focused' : ''}`}
                    required
                  />
                </div>

                {error && (
                  <div className="error-message">
                    <span className="error-icon">!</span>
                    {error}
                  </div>
                )}

                <button 
                  type="submit" 
                  className="forgot-button"
                  disabled={isLoading || !email.trim()}
                >
                  {isLoading ? (
                    <div className="spinner"></div>
                  ) : (
                    'Send Reset Link'
                  )}
                </button>
              </form>
            </>
          )}
        </div>
      </div>
    </div>
  );
};

export default ForgotPassword;