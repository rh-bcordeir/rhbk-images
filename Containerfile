FROM registry.redhat.io/rhbk/keycloak-rhel9:26.4 as builder

WORKDIR /opt/keycloak

# Habilita endpoints de health e métricas
# Adicione aqui outras build options: https://www.keycloak.org/server/all-config?f=build
ENV KC_HEALTH_ENABLED=true \
    KC_METRICS_ENABLED=true \
    KC_TRANSACTION_XA_ENABLED=false \
    KC_DB=mssql

# Re-augmentation
RUN /opt/keycloak/bin/kc.sh build

#################
# Final image  ##
#################
FROM registry.redhat.io/rhbk/keycloak-rhel9:26.4
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
