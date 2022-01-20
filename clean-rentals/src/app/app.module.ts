import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AuthHttpInterceptor, AuthModule } from '@auth0/auth0-angular';
import { AppRoutingModule } from './app-routing.module';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { GoogleChartsModule } from 'angular-google-charts';

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
import { ManageReservationsComponent } from './pages/manage-reservations/manage-reservations.component';
import { CarElementComponent } from './components/cars-content/car-element/car-element.component';
import { ReplacePipe } from './pipes/replace.pipe';
import { PofileContentComponent } from './components/pofile-content/pofile-content.component';
import { ChartComponent } from './components/pofile-content/chart/chart.component';

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
    ManageReservationsComponent,
    CarElementComponent,
    ReplacePipe,
    PofileContentComponent,
    ChartComponent,
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
    FontAwesomeModule,
    AgmCoreModule.forRoot({
      apiKey: 'AIzaSyCjQIrikhLzGX13pF_XoNM6ZcCHoCH0zXs'
    }),
    GoogleChartsModule
  ],
  schemas: [ CUSTOM_ELEMENTS_SCHEMA ], // https://stackoverflow.com/a/68361628/10470183
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
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}