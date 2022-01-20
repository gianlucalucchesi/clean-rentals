import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ReservationService {
  constructor(private http: HttpClient) {}

  getReservation$(id: string): Observable<any> {
    return this.http.get(environment.ApiUrl + 'v1/reservation/private/client/' + id + '/reservations')
  }
}
