package com.cleanrentals.api.services;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Client;
import com.cleanrentals.api.models.Reservation;
import com.cleanrentals.api.models.ReservationFinalizationDTO;
import com.cleanrentals.api.repositories.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;
    @Autowired
    private ClientService clientService;

    public List<Reservation> findAll() {
        System.out.println("All reservations retrieved");
        return this.reservationRepository.findAll();
    }

    public Reservation findById(UUID id) throws NotFoundException {
        Optional<Reservation> optionalReservation = reservationRepository.findById(id);

        if (optionalReservation.isEmpty()) {
            throw new NotFoundException(String.format("Reservation with id %s not found", id));
        }

        System.out.printf("Reservation %s retrieved\n", id);
        return optionalReservation.get();
    }

    public List<Reservation> findByClientId(UUID id) throws NotFoundException {
        Client client = this.clientService.findById(id);
        Optional<List<Reservation>> optionalReservationList = reservationRepository.findByClient(client);

        if (optionalReservationList.isEmpty()) {
            throw new NotFoundException(String.format("No reservations found for client with id %s", id));
        }

        System.out.printf("Reservations for client %s retrieved\n", id);
        return optionalReservationList.get();
    }

    /**
     * Rollback annotation: if ConflictException occurs
     * https://stackoverflow.com/a/62430809
     *
     * @param reservation
     * @return
     * @throws ConflictException
     */
    @Transactional(rollbackFor = ConflictException.class)
    public Reservation create(Reservation reservation) throws ConflictException {
        if (reservation.getId() != null) {
            Optional<Reservation> optionalReservation = this.reservationRepository.findById(reservation.getId());

            if (optionalReservation.isPresent())
                throw new ConflictException(String.format("Reservation %s already exists", reservation.getId()));
        }

        if (reservation.getId() == null)
            reservation.setId(UUID.randomUUID());

        reservation.setReturned(false);
        reservation.setPaid(false);
        reservation.setCancelled(false);

        reservationRepository.saveAndFlush(reservation);

        List<Reservation> inDbReservations = reservationRepository.findReservationBetweenDates(
                reservation.getCar(), reservation.getDateTimeStart(), reservation.getDateTimeStop());

        List<Reservation> activeReservations = inDbReservations.stream().filter(res -> !res.getCancelled()).toList();

        // > 1 because both are recorded but one will be removed with rollback
        if (inDbReservations.size() > 1 && activeReservations.size() > 1) {
            throw new ConflictException("Double reservation for the same car");
        }

        reservationRepository.flush();
        System.out.printf("Reservation %s created\n", reservation.getId());
        return reservation;
    }

    @Transactional(rollbackFor = NotFoundException.class)
    public Reservation setReservationAsPaid(String reservationId) throws NotFoundException {

        Optional<Reservation> optionalReservation = this.reservationRepository.findById(UUID.fromString(reservationId));

        if (optionalReservation.isEmpty()) {
            throw new NotFoundException(String.format("Reservation %s not found", reservationId));
        }

        Reservation reservation = optionalReservation.get();
        reservation.setPaid(true);

        reservationRepository.saveAndFlush(reservation);
        System.out.printf("Reservation %s marked as paid\n", reservationId);

        return reservation;
    }

    public Reservation finalize(String reservationId, ReservationFinalizationDTO reservationFinalization)
            throws NotFoundException, ConflictException {

        Optional<Reservation> optionalReservation = this.reservationRepository.findById(UUID.fromString(reservationId));

        if (optionalReservation.isEmpty()) {
            throw new NotFoundException(String.format("Reservation %s not found", reservationId));
        }

        if (optionalReservation.get().getCancelled()) {
            throw new ConflictException(String.format("Reservation %s was already cancelled", reservationId));
        }

        if (optionalReservation.get().getReturned()) {
            throw new ConflictException(String.format("Reservation %s already returned", reservationId));
        }

        Reservation reservation = optionalReservation.get();
        reservation.setReview_text(reservationFinalization.getReview());
        reservation.setImagePath(reservationFinalization.getImagePath());
        reservation.setReturned(true);

        reservationRepository.saveAndFlush(reservation);
        System.out.printf("Reservation %s finalized\n", reservationId);

        return reservation;
    }

    @Transactional(rollbackFor = NotFoundException.class)
    public void cancel(String reservationId) throws NotFoundException, ConflictException {
        Optional<Reservation> optionalReservation = this.reservationRepository.findById(UUID.fromString(reservationId));

        if (optionalReservation.isEmpty()) {
            throw new NotFoundException(String.format("Reservation %s not found", reservationId));
        }

        if (optionalReservation.get().getCancelled()) {
            throw new ConflictException(String.format("Reservation %s was already cancelled", reservationId));
        }

        if (optionalReservation.get().getReturned()) {
            throw new ConflictException(String.format("Reservation %s was already finalized", reservationId));
        }

        Reservation reservation = optionalReservation.get();
        reservation.setCancelled(true);

        reservationRepository.saveAndFlush(reservation);

        System.out.printf("Reservation %s cancelled\n", reservationId);
    }

}
