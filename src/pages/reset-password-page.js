import React, { useState, useEffect } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import axios from 'axios';
import './reset-password-page.css';

const EyeIcon = () => (
  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#333" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
    <circle cx="12" cy="12" r="3"></circle>
  </svg>
);

const EyeSlashIcon = () => (
  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#333" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
    <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
    <line x1="1" y1="1" x2="23" y2="23"></line>
  </svg>
);

const ResetPassword = () => {
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [focusedField, setFocusedField] = useState(null);
  const [success, setSuccess] = useState(false);
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const navigate = useNavigate();
  const location = useLocation();

  const queryParams = new URLSearchParams(location.search);
  const token = queryParams.get('token');

  useEffect(() => {
    if (!token) {
      setError('Invalid or missing reset token. Please use the link from your email.');
    }
  }, [token]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    setError('');

    try {
      if (!token) throw new Error('Missing reset token');
      if (newPassword.length < 6) throw new Error('Password must be at least 6 characters');
      if (newPassword !== confirmPassword) throw new Error("Passwords don't match");

      const response = await axios.post(
        `http://localhost:5000/v1/auth/reset-password?token=${token}`, 
        { password: newPassword },
        { headers: { 'Content-Type': 'application/json' } }
      );

      if (response.status === 204) {
        setSuccess(true);
        setTimeout(() => navigate('/login'), 2000);
      }
    } catch (err) {
      setError(err.response?.data?.message || err.message || 'Password reset failed');
    } finally {
      setIsLoading(false);
    }
  };

  if (success) {
    return (
      <div className="reset-container">
        <div className="form-center-container">
          <div className="reset-card">
            <h2 className="success-title">Password Updated!</h2>
            <p>Your password has been successfully reset.</p>
            <p>You'll be redirected to login shortly...</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="reset-container">
      <div className="form-center-container">
        <div className="reset-card">
          <h2 className="reset-title">Reset Password</h2>
          <p>Enter your new password below to reset your account access.</p>

          {error && !token && (
            <div className="error-message">
              <span className="error-icon">!</span>
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="reset-form">
            {/* New Password */}
            <div className="input-group">
  <input
    type={showNewPassword ? 'text' : 'password'}
    value={newPassword}
    onChange={(e) => setNewPassword(e.target.value)}
    placeholder="New password (min 6 characters)"
    className="input-field"
    minLength="6"
    required
    disabled={!token}
  />
  {newPassword && (
    <span
      className="eye-toggle"
      onMouseDown={(e) => e.preventDefault()}
      onClick={() => setShowNewPassword(!showNewPassword)}
    >
      {showNewPassword ? <EyeSlashIcon /> : <EyeIcon />}
    </span>
  )}
</div>

<div className="input-group">
  <input
    type={showConfirmPassword ? 'text' : 'password'}
    value={confirmPassword}
    onChange={(e) => setConfirmPassword(e.target.value)}
    placeholder="Confirm new password"
    className="input-field"
    required
    disabled={!token}
  />
  {confirmPassword && (
    <span
      className="eye-toggle"
      onMouseDown={(e) => e.preventDefault()}
      onClick={() => setShowConfirmPassword(!showConfirmPassword)}
    >
      {showConfirmPassword ? <EyeSlashIcon /> : <EyeIcon />}
    </span>
  )}
</div>




            {error && token && (
              <div className="error-message">
                <span className="error-icon">!</span>
                {error}
              </div>
            )}

            <button 
              type="submit" 
              className="reset-button"
              disabled={isLoading || !token}
            >
              {isLoading ? <div className="spinner"></div> : 'Update Password'}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default ResetPassword;
