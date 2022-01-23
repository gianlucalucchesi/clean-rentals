import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class CarService {
  constructor(private http: HttpClient) {}

  getCars$(): Observable<any> {
    return this.http.get(environment.ApiUrl + 'v1/car');
  }

  getCarById$(id: string): Observable<any> {
    return this.http.get(environment.ApiUrl + 'v1/car/private/' + id);
  }

  getPaginatedCars$(pageNumber: number, pageSize: number): Observable<any> {
    // (pageNumber - 1) because starts at 0 in API but at 1 in front-end
    return this.http.get(
      environment.ApiUrl + 'v1/car/pagination/' + (pageNumber - 1) + '/' + pageSize
    );
  }

}
