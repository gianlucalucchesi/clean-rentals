import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '@auth0/auth0-angular';
import { CarDetailsComponent } from './components/cars-content/car-details/car-details.component';
import { CarReservationComponent } from './components/cars-content/car-reservation/car-reservation.component';
import { CarsContentComponent } from './components/cars-content/cars-content.component';
import { ReservationContentComponent } from './components/reservation-content/reservation-content.component';
import { ReservationDetailComponent } from './components/reservation-content/reservation-detail/reservation-detail.component';
import { CarsComponent } from './pages/cars/cars.component';
import { HomeComponent } from './pages/home/home.component';
import { LocationsComponent } from './pages/locations/locations.component';
import { ManageReservationsComponent } from './pages/manage-reservations/manage-reservations.component';
import { ProfileComponent } from './pages/profile/profile.component';
import { ShoppingCartComponent } from './pages/shopping-cart/shopping-cart.component';

const routes: Routes = [
  { path: '', component: HomeComponent, pathMatch: 'full' },
  { path: 'profile', component: ProfileComponent, canActivate: [AuthGuard] },
  {
    path: 'locations',
    component: LocationsComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'shopping-cart',
    component: ShoppingCartComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'manage-reservations',
    component: ManageReservationsComponent,
    canActivate: [AuthGuard],
    children: [
      { path: '', component: ReservationContentComponent },
      { path: ':id', component: ReservationDetailComponent },
    ],
  },
  {
    path: 'cars-overview',
    component: CarsComponent,
    canActivate: [AuthGuard],
    children: [
      { path: '', component: CarsContentComponent },
      {
        path: ':id',
        component: CarDetailsComponent,
        children: [{ path: 'reserve', component: CarReservationComponent }],
      },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
