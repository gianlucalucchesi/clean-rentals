import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '@auth0/auth0-angular';
import { CarsComponent } from './pages/cars/cars.component';
import { ExternalApiComponent } from './pages/external-api/external-api.component';
import { HomeComponent } from './pages/home/home.component';
import { LocationsComponent } from './pages/locations/locations.component';
import { ManageReservationsComponent } from './pages/manage-reservations/manage-reservations.component';
import { ProfileComponent } from './pages/profile/profile.component';
import { ShoppingCartComponent } from './pages/shopping-cart/shopping-cart.component';

const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'profile', component: ProfileComponent, canActivate: [AuthGuard] },
  {
    path: 'external-api',
    component: ExternalApiComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'locations',
    component: LocationsComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'shopping-cart',
    component: ShoppingCartComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'manage-reservations',
    component: ManageReservationsComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'cars',
    component: CarsComponent,
    canActivate: [AuthGuard]
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
