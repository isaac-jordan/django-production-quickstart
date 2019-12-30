from django.urls import path

import home.views as home_views

urlpatterns = [
    path('', home_views.home, name='home'),
]
