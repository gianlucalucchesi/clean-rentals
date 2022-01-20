import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ReservationService {
  private currentReservationId: string;
  currentReservationId$ = new Subject<string>();

  constructor(private http: HttpClient) {}

  getReservation$(id: string): Observable<any> {
    return this.http.get(environment.ApiUrl + 'v1/reservation/private/client/' + id + '/reservations')
  }

  setCurrentReservationId(id: string) {
    this.currentReservationId = id;
    this.currentReservationId$.next(this.currentReservationId);
  }

}
