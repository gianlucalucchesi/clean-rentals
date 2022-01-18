import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  constructor(private http: HttpClient) {}

  ping$(): Observable<any> {
    return this.http.get(environment.ApiUrl + 'v1/brand');
  }

  pingSecureApi$(): Observable<any> {
    return this.http.get(environment.ApiUrl + 'v1/car/private/4b382726-4733-4ad2-b2f6-2acc68fba4b0');

  }
}
