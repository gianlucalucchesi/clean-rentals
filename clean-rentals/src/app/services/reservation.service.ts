import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { environment } from '../../environments/environment';
import { Reservation } from '../models/reservation.model';

@Injectable({
  providedIn: 'root'
})
export class ReservationService {
  private currentReservationId: string;
  currentReservationId$ = new Subject<string>();
  private reserveMode = false;
  reserveModeChanged$ = new Subject<boolean>();
  reservation: Reservation;

  constructor(private http: HttpClient) {}

  getClientReservations$(id: string): Observable<any> {
    return this.http.get(environment.ApiUrl + 'v1/reservation/private/client/' + id + '/reservations')
  }

  getReservationItem$(id: string): Observable<any> {
    return this.http.get(environment.ApiUrl + 'v1/reservation/private/' + id);
  }

  setCurrentReservationId(id: string): void {
    this.currentReservationId = id;
    this.currentReservationId$.next(this.currentReservationId);
  }

  getReserveMode(): boolean {
    return this.reserveMode;
  }

  setReserveMode(reserveMode: boolean): void {
    this.reserveMode = reserveMode;
    this.reserveModeChanged$.next(this.reserveMode);
  }

}
