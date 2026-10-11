from __future__ import annotations

from django.urls import path

from .views import UserDetailView, UserListView, UserProfileView, UserSessionListView, me

urlpatterns = [
    path('', UserListView.as_view(), name='user-list'),
    path('me/', me, name='user-me'),
    path('<int:pk>/', UserDetailView.as_view(), name='user-detail'),
    path('profile/<int:pk>/', UserProfileView.as_view(), name='user-profile'),
    path('sessions/', UserSessionListView.as_view(), name='user-sessions'),
]
