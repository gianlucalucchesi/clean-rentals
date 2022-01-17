import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  constructor(private http: HttpClient) {}

  ping$(): Observable<any> {
    return this.http.get(`http://localhost:8080/api/v1/brand`);
  }

  pingSecureApi$(): Observable<any> {
    return this.http.get(`http://localhost:8080/api/v1/car/private/4b382726-4733-4ad2-b2f6-2acc68fba4b0`);

  }
}
