import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import Header from '../components/header';
import './profile.css';

const UserProfile = () => {
  // State declarations
  const [userData, setUserData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    avatar: '',
    createdAt: '',
    streak: 0,
    role: ''
  });
  const [loading, setLoading] = useState(true);
  const [editable, setEditable] = useState(false);
  const [avatarFile, setAvatarFile] = useState(null);
  const [avatarPreview, setAvatarPreview] = useState('');
  const [apiError, setApiError] = useState('');
  const [apiSuccess, setApiSuccess] = useState('');
  const navigate = useNavigate();

  // Fetch user data
  const fetchUser = async () => {
    try {
      setLoading(true);
      const token = localStorage.getItem('accessToken');
      if (!token) throw new Error('No token');
      
      const response = await axios.get('http://localhost:5000/v1/users/me', {
        headers: { Authorization: `Bearer ${token}` }
      });
      
      const [firstName, ...lastNameParts] = response.data.name ? response.data.name.split(' ') : ['', ''];
      const lastName = lastNameParts.join(' ');

      setUserData({
        ...response.data,
        firstName,
        lastName,
        streak: response.data.streak || 0
      });
      
      setAvatarPreview(response.data.avatar || '/default-avatar.png');
    } catch (err) {
      handleApiError(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUser();
  }, []);

  const handleApiError = (err) => {
    console.error('API Error:', err);
    const errorMessage = err.response?.data?.message || 'Something went wrong';
    setApiError(errorMessage);
    
    if (err.response?.status === 401) {
      localStorage.clear();
      navigate('/login');
    }
  };

  const handleLogout = async () => {
    try {
      const refreshToken = localStorage.getItem('refreshToken');
      await axios.post('http://localhost:5000/v1/auth/logout', { refreshToken });
    } catch (err) {
      console.error('Logout error:', err);
    } finally {
      localStorage.clear();
      navigate('/login');
    }
  };

  const handleDeleteAccount = async () => {
    if (!window.confirm('Are you sure you want to permanently delete your account?')) return;

    try {
      const token = localStorage.getItem('accessToken');
      await axios.delete('http://localhost:5000/v1/users/me', {
        headers: { Authorization: `Bearer ${token}` }
      });
      localStorage.clear();
      navigate('/register');
    } catch (err) {
      handleApiError(err);
    }
  };

  const handleEditToggle = () => {
    setEditable(!editable);
    setApiError('');
    setApiSuccess('');
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setUserData(prev => ({ ...prev, [name]: value }));
  };

  const handleSave = async () => {
    try {
      const token = localStorage.getItem('accessToken');
      const { firstName, lastName, email } = userData;
      
      await axios.patch(
        'http://localhost:5000/v1/users/me',
        { 
          name: `${firstName} ${lastName}`.trim(),
          email 
        },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      setEditable(false);
      setApiSuccess('Profile updated successfully!');
      setTimeout(() => setApiSuccess(''), 3000);
    } catch (err) {
      handleApiError(err);
    }
  };

  const handleAvatarChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setAvatarFile(file);
      setAvatarPreview(URL.createObjectURL(file));
    }
  };

  const handleUploadAvatar = async () => {
    if (!avatarFile) {
      setApiError('Please select an image file');
      setTimeout(() => setApiError(''), 3000);
      return;
    }

    try {
      const token = localStorage.getItem('accessToken');
      const formData = new FormData();
      formData.append('avatar', avatarFile);

      const response = await axios.post(
        'http://localhost:5000/v1/users/me/avatar',
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'multipart/form-data'
          }
        }
      );

      setUserData(prev => ({ ...prev, avatar: response.data.avatar }));
      setApiSuccess('Avatar updated successfully!');
      setTimeout(() => setApiSuccess(''), 3000);
    } catch (err) {
      handleApiError(err);
    }
  };

  if (loading) {
    return (
      <div className="user-profile-page">
        <Header />
        <div className="loading-spinner">Loading...</div>
      </div>
    );
  }

  return (
    <div className="user-profile-page">
      <Header />
  
      <main className="user-profile-container">
        {apiError && (
          <div className="alert alert-error">
            {apiError}
            <button className="alert-close" onClick={() => setApiError('')}>×</button>
          </div>
        )}
        {apiSuccess && (
          <div className="alert alert-success">
            {apiSuccess}
            <button className="alert-close" onClick={() => setApiSuccess('')}>×</button>
          </div>
        )}
  
        <div className="profile-card">
          <div className="profile-header">
            <h2>Profile Information</h2>
          </div>
          
          <div className="profile-content">
            <div className="avatar-section">
              <div className="avatar-wrapper">
                <img
                  src={avatarPreview}
                  alt="Profile"
                  className="user-avatar"
                  onError={(e) => {
                    e.target.src = '/default-avatar.png';
                  }}
                />
              </div>
              <div className="avatar-controls">
                <input
                  type="file"
                  id="avatar-upload"
                  accept="image/*"
                  onChange={handleAvatarChange}
                  style={{ display: 'none' }}
                />
                <label htmlFor="avatar-upload" className="btn btn-outline">
                  Change Photo
                </label>
                <button
                  onClick={handleUploadAvatar}
                  className="btn btn-primary"
                  disabled={!avatarFile}
                >
                  Save Photo
                </button>
              </div>
            </div>
  
            <div className="info-section">
              <div className="form-group">
                <div className="form-row">
                  <div className="form-field">
                    <label>First Name</label>
                    <input
                      type="text"
                      name="firstName"
                      value={userData.firstName}
                      onChange={handleChange}
                      readOnly={!editable}
                      className={editable ? 'editable' : 'read-only'}
                    />
                  </div>
                  <div className="form-field">
                    <label>Last Name</label>
                    <input
                      type="text"
                      name="lastName"
                      value={userData.lastName}
                      onChange={handleChange}
                      readOnly={!editable}
                      className={editable ? 'editable' : 'read-only'}
                    />
                  </div>
                </div>
  
                <div className="form-field">
                  <label>Email Address</label>
                    <input
                      type="email"
                      name="email"
                      value={userData.email}
                      onChange={handleChange}
                      readOnly={!editable}
                      className={editable ? 'editable' : 'read-only'}
                    />
                </div>
  
                <div className="form-row">
                  <div className="form-field">
                    <label>Member Since</label>
                    <input
                      type="text"
                      value={new Date(userData.createdAt).toLocaleDateString()}
                      readOnly
                      className="read-only"
                    />
                  </div>
                  <div className="form-field">
                    <label>Current Streak</label>
                    <input
                      type="text"
                      value={`${userData.streak} days`}
                      readOnly
                      className="read-only"
                    />
                  </div>
                </div>
              </div>
  
             
            </div>
          </div>
        </div>
        <div className="action-btn">
                {!editable ? (
                  <button onClick={handleEditToggle} className="btn btn-primary">
                    Edit Profile
                  </button>
                ) : (
                  <>
                    <button onClick={handleSave} className="btn btn-primary">
                      Save Changes
                    </button>
                    <button onClick={handleEditToggle} className="btn btn-secondary">
                      Cancel
                    </button>
                  </>
                )}
                <button onClick={handleLogout} className="btn btn-warning">
                  Logout
                </button>
                <button onClick={handleDeleteAccount} className="btn btn-danger">
                  Delete Account
                </button>
              </div>
      </main>
    </div>
    
  );
};

export default UserProfile;