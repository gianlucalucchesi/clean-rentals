import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { HighlightModule, HIGHLIGHT_OPTIONS } from 'ngx-highlightjs';
import { AuthHttpInterceptor, AuthModule } from '@auth0/auth0-angular';
import { AppRoutingModule } from './app-routing.module';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

import { AppComponent } from './app.component';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { environment as env } from '../environments/environment';
import { FooterComponent } from './components/footer/footer.component';
import { HomeComponent } from './pages/home/home.component';
import { ProfileComponent } from './pages/profile/profile.component';
import { HomeContentComponent } from './components/home-content/home-content.component';
import { LoadingComponent } from './components/loading/loading.component';
import { ExternalApiComponent } from './pages/external-api/external-api.component';
import { LocationsContentComponent } from './components/locations-content/locations-content.component';
import { CarsContentComponent } from './components/cars-content/cars-content.component';
import { CarsComponent } from './pages/cars/cars.component';
import { LocationsComponent } from './pages/locations/locations.component';
import { AgmCoreModule } from '@agm/core';
import { ShoppingCartComponent } from './pages/shopping-cart/shopping-cart.component';
import { MannageBookingsComponent } from './pages/mannage-bookings/mannage-bookings.component';
import { ManageBookingsComponent } from './pages/manage-bookings/manage-bookings.component';

@NgModule({
  declarations: [
    AppComponent,
    NavBarComponent,
    FooterComponent,
    HomeComponent,
    ProfileComponent,
    HomeContentComponent,
    LoadingComponent,
    ExternalApiComponent,
    LocationsContentComponent,
    CarsContentComponent,
    CarsComponent,
    LocationsComponent,
    ShoppingCartComponent,
    MannageBookingsComponent,
    ManageBookingsComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    NgbModule,
    AuthModule.forRoot({
      ...env.auth,
      httpInterceptor: {
        ...env.httpInterceptor,
      },
    }),
    HighlightModule,
    FontAwesomeModule,
    AgmCoreModule.forRoot({
      apiKey: 'AIzaSyCjQIrikhLzGX13pF_XoNM6ZcCHoCH0zXs'
    }),
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthHttpInterceptor,
      multi: true,
    },
    {
      provide: Window,
      useValue: window,
    },
    {
      provide: HIGHLIGHT_OPTIONS,
      useValue: {
        coreLibraryLoader: () => import('highlight.js/lib/core'),
        languages: {
          json: () => import('highlight.js/lib/languages/json'),
        },
      },
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
